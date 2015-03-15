module Nessus
  class Client
    # @author Erran Carey <me@errancarey.com>
    # updated by @author Javier <javierc@unm.edu>
    module Scan
      # POST /scans
      #
      # @param [String] The uuid for the editor template to use.
      # @param [String] target a string that contains the scan target(s)
      # @param [Fixnum] policy_id a numeric ID that references the policy to use
      # @param [String] scan_name the name to assign to this scan
      # @param [Fixnum] seq a unique identifier for the specific request
      #
      # @return [Hash] the newly created scan object
      def scan_new(uuid, target, policy_id, scan_name, enabled, other=nil)
        payload = {
          :uuid => uuid,
          :settings => {
            :enabled => enabled,
            :text_targets => target,
            :policy_id => policy_id,
            :name => scan_name
          }
        }
        if other
          payload.merge(other)
        end

        post '/scans', payload

        # if  response['error']
        #   raise Nessus::UnknownError, response['error']
        # end

        # response['reply']['contents'] # ['scan']
      end

      # GET /scans
      #
      # @return [Array<Hash>] an array of scan hashes
      def scan_list
        response = get '/scans'
        response['scans']
      end

      # POST /scans/{scan_id}/stop
      #
      # @param [integer] scan_id unique identifier for the scan
      #
      # @return status OK if successful
      def scan_stop(scan_id)
        post "/scans/#{scan_id}/stop"
      end

      # POST /scans/{scan_id}/pause
      #
      # @param [integer] scan_id unique identifier for the scan
      #
      # @return status OK if successful
      def scan_pause(scan_id)
        post "/scans/#{scan_id}/pause"
      end


      # POST /scans/{scan_id}/export
      #
      # @param [integer] scan_id id of the scan to export.
      # @param [string] format file format to use (Nessus, HTML, PDF, CSV, or DB).
      #
      # @return 
      def scan_export(scan_id, format)
        post "/scans/#{scan_id}/export"
      end

      
      # POST /scans/{scan_id}/resume
      #
      # @param [integer] scan_id unique identifier for the scan
      #
      # @return status OK if successful
      def scan_resume(scan_id)
        post "/scans/#{scan_id}/resume"
      end

      # POST /scans/{scan_id}/launch
      #
      # @param [integer] scan_id id of the scan to launch
      #
      # @return status OK if successful
      def scan_launch(scan_id)
        post "/scans/#{scan_id}/launch"
      end

      # POST /scan/template/new
      #
      # @param [String] scan template name
      # @param [String] scan policy identifier
      # @param [String] targets for scan template
      #
      # @return status OK if successful
      def scan_template_new(template_name, policy_id, target, seq = nil, start_time = nil, rrules = nil)
        raise NotImplementedError
        payload = {
          :template_name => template_name,
          :policy_id => policy_id,
          :target => target
        }
        payload[:seq] = seq if seq
        payload[:startTime] = start_time if start_time
        payload[:rRules] = rrules if rrules
        response = post '/scan/template/new', payload

        if response['reply']['status'].eql? 'ERROR'
          raise Nessus::UnknownError, response['reply']['contents']
        end

        response['reply']['contents'] # ['scan']
      end
    end
  end
end
