# -*- coding: utf-8 -*-
require 'rubygems'
require 'watir-webdriver'

$url = "http://adview.cn/register?user=hailong0707@gmail.com"

$existed_qq_filename = "qqlist"
qq_file = File.open($existed_qq_filename, "r")
str = qq_file.read
numbers = str.split("\n").map{ |l| l.strip }.map{ |l| l.to_i }
index = (1 .. 10).to_a

arr1 = index.map{|i| Random.rand(1000000000)}

arr2 = arr1.select{|i| i > 100000000 }

#arr3 = arr2.select { |n| numbers.index(n) == nil }

$all = arr2
#puts "all size : #{$all.size}"


#def newpass( len )
#  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
#  newpass = ""
#  1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
#  return newpass
#end

def mail()
  mails = ["gmail", "163", "qq", "126", "hotmail", "qq", "sohu", "163", "qq","sina", "qq", "yahoo", "qq"]
  mail = mails[rand (mails.size - 1)]
  return mail
end


def run_once(qq, mail)
  browser = Watir::Browser.new(:chrome)
  cmd = "echo #{qq} >> #{$existed_qq_filename}"
  puts cmd
  `#{cmd}`
  browser.goto $url

  password = qq.to_s.reverse

  browser.text_field(:name => "username").set "#{qq}@#{mail}.com"
  browser.text_field(:name => "password").value = password
  browser.text_field(:name => "verify").value = password
  browser.text_field(:name => "question").set "qq是什么qq是什么qq是什么"
  browser.text_field(:name => "answer").set "#{qq}"

#  form = browser.forms.last
#  form.submit

end

$all.each{ |qq|
  run_once(qq, mail) }
