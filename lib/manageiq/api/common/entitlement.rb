module ManageIQ
  module API
    module Common
      class EntitlementError < StandardError; end

      class Entitlement
        def initialize(identity)
          @identity = identity
        end

        %w[
          hybrid_cloud
          insights
          openshift
          smart_management
        ].each do |m|
          define_method(m) do
            find_entitlement_key(m)
          end
        end

        private

        attr_reader :identity

        def find_entitlement_key(key)
          result = identity.dig('entitlements', key.to_s)
          return true unless result
          #raise EntitlementError, "#{key} doesn't exist" if result.nil?
          result['is_entitled']
        end
      end
    end
  end
end
