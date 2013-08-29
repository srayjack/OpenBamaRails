class RenameConfigurationTable < ActiveRecord::Migration
    def change
        rename_table :configurations, :app_configurations
    end 
end
