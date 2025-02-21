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

class AddOAuthClientTypeToRemoteIdentities < ActiveRecord::Migration[7.1]
  def up
    add_column :remote_identities, :oauth_client_type, :string
    add_column :remote_identities, :integration_type, :string
    add_column :remote_identities, :integration_id, :bigint

    add_index :remote_identities, %i[oauth_client_type integration_id integration_type]

    remove_foreign_key :remote_identities, :oauth_clients
    execute <<~SQL.squish
      UPDATE remote_identities SET oauth_client_type = 'OAuthClient'
    SQL

    # TODO fill in integration_id integration_type based on oauth_client.integration data
    # TODO add not null constraints for new columns.
    #
  end

  def down
    remove_column :remote_identities, :oauth_client_type
    remove_column :remote_identities, :integration_id
    remove_column :remote_identities, :integration_type
    add_foreign_key :remote_identities, :oauth_clients
  end
end
