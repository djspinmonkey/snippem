#!/usr/bin/ruby

require 'rubygems'
require 'activeresource'
require 'net/imap'
require 'tmail'

server    = 'imap.gmail.com'
port      = 993
username  = 'xiocom.snippem@gmail.com'
password  = 'snipsnip'

class Snippet < ActiveResource::Base
  self.site = "http://localhost:3000"
end

imap = Net::IMAP.new(server,port,true)
imap.login(username, password)
imap.select('INBOX')
imap.search(["NOT", "DELETED"]).each do |message_id|
  email = TMail::Mail.parse(imap.fetch(message_id, "RFC822")[0].attr["RFC822"])
  user = email.from[0].sub(/@xiocom.com/, '')
  body = email.multipart? ? email.parts.first.body : email.body
  snippet = Snippet.new(:user => user, :title => email.subject, :contents => body)
  snippet.save()
  imap.store(message_id, "+FLAGS", [:Deleted])
end
imap.logout()
#imap.disconnect()

