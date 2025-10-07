if Rails.env.development?
  Rails.logger.info "🔧 Using relaxed session store for development (allow cross-origin cookies)"

  Rails.application.config.session_store :cookie_store,
    key: '_openproject_session',
    same_site: :none,
    secure: false,
    domain: :all
end

