require 'json'
require 'htmlbeautifier'

IGNORED_DIRS = %w(assets bin public css js vendor)
ALLOWED_EXTS = %w(.md .html .pdf)

def directory_hash(path, name=nil, parent=nil)
  id = [parent, (name || path)].compact.join('-')
  data = { id: id, data: (name || path) }
  data[:children] = children = []
  Dir.foreach(path) do |entry|
    # Skip Hidden Files
    next if entry.start_with?('.') || entry.start_with?('_')
    # Skip files unless they are a directory or a file with an allowed extension
    next if !ALLOWED_EXTS.include?(File.extname(entry)) && !File.directory?(File.join(path, entry))
    # Skip ignored directories
    next if IGNORED_DIRS.include?(entry)

    # Actually parse the children list recursively
    full_path = File.join(path, entry)
    if File.directory?(full_path)
      if h = directory_hash(full_path, entry, id)
        children << h
      end
    else
      children << entry
    end
  end
  data
end

def to_toc(toc_array, sidebar = false, prefix = '')
  list = []
  toc_array.each do |entry|
    if entry.is_a?(Hash)
      next if entry[:children].empty?
      sub_toc = to_toc(entry[:children], sidebar, File.join(prefix,entry[:data]))
      list << "<li #{"class='file'" if sidebar}>#{section_title(entry, sidebar, prefix)}#{sub_toc}</li>"
    else
      entry_wo_ext = if File.extname(entry) == '.html' || File.extname(entry) == '.md'
        entry.split('.')[0..-2].join('.')
      else
        entry
      end
      next if entry_wo_ext == 'index' || entry_wo_ext == 'README'
      href = File.join(prefix, entry_wo_ext)
      list << "<li #{"class='file'" if sidebar} ><a href='#{href}'>#{humanize(entry_wo_ext)}</a></li>"
    end
  end

  if sidebar
    "<ol#{prefix == '' ? ' class="tree"' : ''}>" + list.join + "</ol>"
  else
    "<ul>" + list.join + "</ul>"
  end
end

def section_title(entry, sidebar, prefix)
  if sidebar
    title = humanize(entry[:data])
    "<label for='#{entry[:id]}'>#{title}</label>" +
    "<input type='checkbox' id='#{entry[:id]}' />"
  else
    "<p>#{humanize(entry[:data])}</p>"
  end
end

def humanize(word)
  result = word.to_s.dup
  result.sub!(/\A_+/, ''.freeze)
  result.sub!(/_id\z/, ''.freeze)
  result.tr!('_'.freeze, ' '.freeze)
  result.gsub!(/\s\w/) { |match| match.upcase }
  result.sub!(/\A\w/) { |match| match.upcase }
  result
end

path = File.expand_path('../../', __FILE__)
toc_hash = directory_hash(path)

# Main TOC
html = to_toc(toc_hash[:children], false)
beautiful = HtmlBeautifier.beautify(html)
path = File.expand_path('../../_includes/toc.html', __FILE__)
File.write(path, beautiful)
