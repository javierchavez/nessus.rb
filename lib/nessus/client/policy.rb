module Nessus
  class Client
    # @author Erran Carey <me@errancarey.com>
    module Policy

      
      # GET /policy
      def policy_list
        resp = get '/policies'
        resp['policies']
      end

      # @!group Policy Auxiliary Methods

      # @return [Array<Array<String>>] an object containing a list of policies
      # and their policy IDs
      def policies
        policy_list.map do |policy|
          [policy['name'], policy['id']]
        end
      end

      # @return [String] looks up policy ID by policy name
      def policy_id_by_name(name)
        policy_list.find{|policy| policy['name'].eql? name}['id']
      rescue
        nil
      end

      # @return [String] looks up policy name by policy ID
      def policy_name_by_id(id)
        policy_list.find{|policy| policy['id'].eql? id}['name']
      rescue
        nil
      end

      #@!endgroup
    end
  end
end
