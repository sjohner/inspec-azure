# frozen_string_literal: true

require 'azurerm_resource'

class AzurermNetworkSecurityGroups < AzurermPluralResource
  name 'azurerm_network_security_groups'
  desc 'Verifies settings for Network Security Groups'
  example <<-EXAMPLE
    azurerm_network_security_groups(resource_group: 'example') do
      it{ should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:names, field: 'name')
             .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil)
    resp = client.network_security_groups(resource_group)
    return if resp.nil? || (resp.is_a?(Hash) && resp.key?('error'))

    @table = resp
  end

  def to_s
    'Network Security Groups'
  end
end
