# coding: utf-8

class FreemlController < ApplicationController
  skip_before_filter :authorize_as_user, only: :batch

  # GET /freeml
  def index
    @entries = FreemlEntry.all
  end

  # GET /freeml/body/:id
  def download_body
    entry = FreemlEntry.find(params[:id])
    body = entry.freeml_body.gsub(/\r|\n/, '<br>')
    body += '<br><br>'
    unless entry.freeml_readable
      body += 'このメールの全文を表示することができません。以下のリンクよりご覧ください。<br>'
    end
    body += ('<a href="http://www.freeml.com/hokudaimedicine93/' + entry.freeml_id.to_s + '" target="_blank">freeMLサイトで見る</a>')
    send_data body
  end

  # GET /freeml/batch
  def batch
    begin
      raise unless request.remote_ip == "127.0.0.1"
    rescue
      render status: 404, file: "#{Rails.root}/public/404.html", layout: false
      return
    end

    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    require '/var/app/setting/hokui/freeml.rb'
    agent.post('https://www.freeml.com/ep.umzx/grid/General/node/SpLoginProcess', freeml_login_info)
    doc = Nokogiri::HTML(agent.get('http://www.freeml.com/hokudaimedicine93/topics').body.toutf8)
    doc.css('.entry_r').each do |entry|
      id = entry.css('a')[0][:href].split('/')[2].strip.gsub(/\r|\n/, '')
      next if FreemlEntry.find(id)

      begin
        user = entry.css('a')[1].children[0].text.strip.gsub(/\r|\n/, '').sub('　', ' ')
      rescue
        user = 'unknown'
      end
      title = entry.css('h4').children[0].text.strip.gsub(/\r|\n/, '')
      datetime = entry.css('.s_10.c_666')[0].children.text.scan(/\d{4}\/\d{2}\/\d{2} \d{2}:\d{2}/).first

      entry_doc = Nokogiri::HTML(agent.get("http://www.freeml.com/hokudaimedicine93/#{id}").body.toutf8)
      entry_body = entry_doc.css('.mlc_text_area1 .mlc_text_14')[0].children.text.strip
      readable = true
      if entry_body == ""
        entry_body = entry.css('p').children[0].text.strip.gsub(/\r|\n/, '')
        readable = false
      end

      FreemlEntry.create!(
        freeml_id: id,
        freeml_user: user,
        freeml_title: title,
        freeml_body: entry_body,
        freeml_readable: readable,
        freeml_datetime: datetime
      )
    end

    render text: 'ok', status: 200
  end

=begin
  #!/usr/bin/env ruby
  #batch 呼び出しスクリプト
  #/var/app/script/hokui/freeml_batch.rb

  require "net/http"
  Net::HTTP.version_1_2
  if __FILE__ == $0
    Net::HTTP.start('www.itakeshi.net', 80) do |http|
      http.get("/freeml/batch")
    end
  end
=end
end
