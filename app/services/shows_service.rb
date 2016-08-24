class ShowsService
  def self.call(params)
    near = params.fetch(:latlng).join(',')
    status = params.fetch(:status, 'running')
    page_count = params.fetch(:pages, 1)

    api_root = Rails.application.config_for(:gravity)['api_root']
    api_endpoint = "shows?near=#{near}&status=#{status}"
    api_url = "#{api_root}/#{api_endpoint}"

    hydra = Typhoeus::Hydra.new
    requests = Array.new(page_count) do |n|
      request = Typhoeus::Request.new(
        "#{api_url}&page=#{n + 1}",
        headers: {
          'X-ACCESS-TOKEN' => Rails.application.config_for(:gravity)['application_token'],
          'User-Agent' => 'Azimuth'
        },
        method: :get
      )
      hydra.queue(request)
      request
    end
    hydra.run

    response = requests.map { |request| JSON.parse(request.response.body) }
    response.flatten!
  end
end
