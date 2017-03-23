IGNORED_DIRS = %w(assets bin public css js vendor jekyll)
ALLOWED_EXTS = %w(.md .html .pdf)

def add_page_toc(contents)
  template =
  <<~TOC
    {:.no_toc}

    <h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
    * Will be replaced with the ToC, excluding the "Contents" header
    {:toc}
  TOC

  contents.sub(/^(?:#) (.*)$/, "# \\1\n\n#{template}")
end

def fix_image_path(contents)
  contents.gsub(/!\[([^\[]*)\]\(([^\)]+)\)/, "![\\1](../\\2)")
end

def format_file(file)
  contents = File.read(file)
  contents = add_page_toc(contents)
  contents = fix_image_path(contents)
  File.write(file, contents)
end

def format_path(path)
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
      format_path(full_path)
    else
      puts full_path
      format_file(full_path)
    end
  end
end

path = File.expand_path('../../', __FILE__)
format_path(path)
