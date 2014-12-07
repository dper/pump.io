#!/usr/local/bin/ruby
# coding: utf-8
#
# This script downloads a bunch of canned coffee images and makes a montage.
# The montage is one column wide and many rows deep.
# The montage is brightened to make it less distracting.
#
# I release this code under a Creative Commons Zero license.
# Please do whatever you want with it.
# Cite the source or author if you want to, or don't if you don't.
#
# Written by Douglas Paul Perkins.
# https://dperkins.org
#
# First created: 2014-11-24.

require 'open-uri'
require 'openssl'
require 'RMagick'
include Magick
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE 

# Keep these files in chronological order.
# This helps avoid duplicates.
files = [
"https://dperkins.org/gal/2013/thumb/2013-08-25.001.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-08-28.05.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-08-29.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-08-30.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-08-31.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-01.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-04.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-06.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-07.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-09.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-11.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-12.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-13.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-22.01.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-23.02.Coffee.Georgia.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-27.01.Coffee.7-11.jpg",
"https://dperkins.org/gal/2013/thumb/2013-09-29.12.Coffee.Georgia.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-01.01.Coffee.Boss.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-03.01.Coffee.Boss.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-04.01.Coffee.Georgia.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-07.01.Coffee.Suntory.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-09.01.Coffee.Georgia.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-10.01.Coffee.Boss.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-11.01.Coffee.Wonda.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-13.01.Coffee.Boss.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-14.23.Coffee.Wonda.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-16.01.Coffee.Georgia.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-18.01.Coffee.Suntory.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-19.01.Coffee.Fire.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-20.01.Coffee.Fire.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-21.01.Coffee.Wonda.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-23.02.Coffee.jpg",
"https://dperkins.org/gal/2013/thumb/2013-10-26.01.Coffee.Roots.jpg",
"https://dperkins.org/gal/2014/thumb/2014-03-13.02.Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-03-22.31.Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-09-07.03.Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-09-08.01.Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-09-29.12.Tully.jpg",
"https://dperkins.org/gal/2014/thumb/2014-09-29.24.Yamazaki%20Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-10-17.02.DyDo.jpg",
"https://dperkins.org/gal/2014/thumb/2014-10-20.01.Fire.jpg",
"https://dperkins.org/gal/2014/thumb/2014-10-26.01.Georgia.jpg",
"https://dperkins.org/gal/2014/thumb/2014-11-02.60.Boss.jpg",
"https://dperkins.org/gal/2014/thumb/2014-11-07.01.Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-11-10.02.Coffee.jpg",
"https://dperkins.org/gal/2014/thumb/2014-11-10.05.Coffee.jpg",
]

images = ImageList.new

files.each do |url|
	open(url, 'rb') do |remote_file|
		image = Magick::Image::from_blob(remote_file.read).first
		images << image
	end
end

width = 50 
height = width * 4/3

montage = images.montage do |m|
	m.tile = '1x' + files.size.to_s
	m.geometry = width.to_s + 'x' + height.to_s + '+0+0'
end

montage = montage.level(0.0, 2.0)
montage.write('coffee.jpg')
