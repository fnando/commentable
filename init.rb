require "has_comments"
ActiveRecord::Base.send(:include, SimplesIdeias::Acts::Comments)

require File.dirname(__FILE__) + "/lib/comment"