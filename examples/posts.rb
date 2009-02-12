#!/usr/bin/env ruby
require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')

class Post
  include ROXML
  
  xml_reader :href, :from => :attr
  xml_reader :hash, :from => :attr
  xml_reader :description, :from => :attr
  xml_reader :tag, :from => :attr
  xml_reader :time, :from => :attr, :as => DateTime
  xml_reader :others, :from => :attr, :as => Integer
  xml_reader :extended, :from => :attr
end

class Posts
  include ROXML

  xml_reader :posts, :as => [Post]
end

unless defined?(Spec)
  posts = Posts.from_xml(xml_for('posts'))
  posts.posts.each do |post|
    puts post.description, post.href, post.extended, ''
  end
end