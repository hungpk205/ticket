class DownloadsController < ApplicationController
  before_action :load_company
  before_action :load_trip
  def show
    respond_to do |format|
      format.html do
        render :show,
        template: "downloads/show.html.erb",
        layout: "trip_pdf/trip_pdf",
        orientation: "Landscape",
        encoding: "UTF-8",
        page_size: "A4"
      end
      format.pdf do
        render pdf: "#{@trip.route.start_place} - #{@trip.route.end_place} - #{@trip.start_time}",
          template: "downloads/show.html.erb",
          layout: "trip_pdf/trip_pdf",
          orientation: "Landscape",
          encoding: "UTF-8",
          page_size: "A4",
          margin:  {top: 5,
                    bottom:5,
                    left: 5,
                    right: 5}
      end
    end
  end

  def load_trip
    @trip = @company.trips.find_by id: params[:id]
    @tickets_t1 = @trip.tickets.tickets_t1
    @tickets_t2 = @trip.tickets.tickets_t2
  end
end
