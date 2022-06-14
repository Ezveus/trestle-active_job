Trestle.admin(:active_job, scope: Trestle::ActiveJob, path: 'active_job') do
  routes do
    post :perform_job
  end

  controller do
    before_action :fetch_jobs

    def index
    end

    def perform_job
      job = params[:job]

      if @jobs.include?(job)
        job.constantize.perform_later
        redirect_to admin.path(:index),
                    notice: I18n.t('perform_success', scope: 'trestle_active_job',
                                   default:                  "'%{job_name}' is scheduled",
                                   job_name:                 I18n.t(job, scope: 'trestle_active_job', default: job))
      else
        redirect_to admin.path(:index),
                    notice: I18n.t('unknown_job', scope: 'trestle_active_job',
                                   default:              "'%{job_name}' does not exists",
                                   job_name:             I18n.t(job, scope: 'trestle_active_job', default: job))
      end
    end

    private

    def fetch_jobs
      @jobs = ObjectSpace.each_object(Class).select { |c| c.ancestors.include?(ActiveJob::Base) }
                         .map(&:to_s)
    end
  end
end
