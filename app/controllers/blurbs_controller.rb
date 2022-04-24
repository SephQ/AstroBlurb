class BlurbsController < ApplicationController
  before_action :set_blurb, only: %i[ show edit update destroy ]

  # GET /blurbs or /blurbs.json
  def index
    @blurbs = Blurb.all
    if params[:commit]
      load_params
      @commit = true
    end
  end

  # GET /blurbs/1 or /blurbs/1.json
  def show
    load_params
  end

  # GET /blurbs/new
  def new
    @blurb = Blurb.new
    if params[:format]
      # User is creating a new version of an old blurb
      # Prefill the title, blurb text and planet-sign replacements from the old article to begin (saves time)
      @prefilled_blurb = Blurb.all.find(params[:format])
    end
  end

  # GET /blurbs/1/edit
  def edit
    @prefilled_blurb = Blurb.all.find(params[:id])  # Prefill the blurb with the current values
  end

  # POST /blurbs or /blurbs.json
  def create
    @blurb = Blurb.new(blurb_params)

    # Notice on screen after save action completes or fails
    respond_to do |format|
      if @blurb.save
        format.html { redirect_to blurb_url(@blurb), notice: "Blurb was successfully created." }
        format.json { render :show, status: :created, location: @blurb }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blurbs/1 or /blurbs/1.json
  def update
    respond_to do |format|
      if @blurb.update(blurb_params)
        format.html { redirect_to blurb_url(@blurb), notice: "Blurb was successfully updated." }
        format.json { render :show, status: :ok, location: @blurb }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blurbs/1 or /blurbs/1.json
  def destroy
    @blurb.destroy

    respond_to do |format|
      format.html { redirect_to blurbs_url, notice: "Blurb was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blurb
      @blurb = Blurb.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blurb_params
      params.require(:blurb).permit(:id, :title, :text, :planet_replacements)
    end
end
