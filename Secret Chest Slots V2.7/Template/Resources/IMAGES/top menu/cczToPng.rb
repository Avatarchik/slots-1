require 'rubygems'
require 'json'
require_relative 'chunky_png.rb'

PLUTIL = '/usr/bin/plutil'
TEXTUREPACKER = '/usr/local/bin/TexturePacker'

dir = File.join(ARGV[0], '*plist')
out_dir = File.join(Dir.pwd , ARGV[1])
tmp_dir = "/tmp"

Dir.glob(dir).each do |plist_file|
  basename = File.basename(plist_file, '.plist')
  Dir.chdir(ARGV[0]) do
    puts "Processing #{basename}"

    next unless File.exists?("#{basename}.pvr.ccz")

    json_file = File.join(tmp_dir, "#{basename}.json")
    png_file = File.join(tmp_dir, "#{basename}.png")

    system "#{PLUTIL} -convert json '#{basename}.plist' -o '#{json_file}'"
    system "#{TEXTUREPACKER} --quiet --disable-rotation --no-trim --padding 0 --shape-padding 0 --border-padding 0 --inner-padding 0 '#{basename}.pvr.ccz' --sheet '#{png_file}' --data /dev/null"

    metadata = JSON.parse(File.read(json_file))

    image = ChunkyPNG::Image.from_file(png_file)
    frames_dir = File.join(out_dir, "#{basename}")
    system "rm -drf '#{frames_dir}'"
    Dir.mkdir(frames_dir)

    metadata['frames'].each_key do |frame_name|
      puts frame_name
      metadata['frames'][frame_name]['textureRect'] =~ /{{(\d+),\s(\d+)},\s{(\d+),\s(\d+)}}/
      cropped = image.crop($1.to_i, $2.to_i, $3.to_i, $4.to_i)
      cropped.save(File.join(frames_dir, frame_name))
    end

    system "rm -f #{json_file} #{json_file}"

  end

end