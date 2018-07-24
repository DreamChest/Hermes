# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  doc_path = "#{Rails.root}/doc"
  FileUtils.mkdir_p(doc_path) unless File.exist?(doc_path)
  RailsERD.load_tasks
end
