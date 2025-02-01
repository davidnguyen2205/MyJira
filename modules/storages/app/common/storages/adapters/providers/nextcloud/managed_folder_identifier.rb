# frozen_string_literal: true

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module Storages
  module Adapters
    module Providers
      module Nextcloud
        class ManagedFolderIdentifier
          def initialize(project_storage)
            @storage = project_storage.storage
            @project = project_storage.project
          end

<<<<<<< HEAD:modules/storages/app/common/storages/peripherals/storage_interaction/authentication_strategies/nextcloud_strategies.rb
          class UserBound
            class << self
              include TaggedLogging

              def call(user:, storage:)
                with_tagged_logger do
                  sso_preferred = storage.audience.present? && oidc_provider_for(user)

                  if sso_preferred
                    ::Storages::Peripherals::StorageInteraction::AuthenticationStrategies::SsoUserToken
                      .strategy
                      .with_user(user)
                  elsif storage.oauth_client.present?
                    ::Storages::Peripherals::StorageInteraction::AuthenticationStrategies::OAuthUserToken
                      .strategy
                      .with_user(user)
                  else
                    error "No user-bound authentication strategy applicable for file storage #{storage.id}."
                    ::Storages::Peripherals::StorageInteraction::AuthenticationStrategies::Failure.strategy
                  end
                end
              end

              private

              def oidc_provider_for(user)
                user.authentication_provider.is_a?(OpenIDConnect::Provider)
              end
            end
=======
          def name
            "#{@project.name.tr('/', '|')} (#{@project.id})"
          end

          def path
            "/#{@storage.group_folder}/#{name}/"
          end

          def location
            path
>>>>>>> 9dd5c60e7ec (Disable Peripherals::Registry):modules/storages/app/common/storages/adapters/providers/nextcloud/managed_folder_identifier.rb
          end
        end
      end
    end
  end
end
