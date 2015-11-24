class DecklistsController < ApplicationController
  before_action :require_user
  before_action :set_decklist, only: [:show, :edit, :update, :destroy]

  # GET /decklists
  # GET /decklists.json
  def index
    @decklists = Decklist.all
  end

  # GET /decklists/1
  # GET /decklists/1.json
  def show
  end

  # GET /decklists/new
  def new
    @decklist = Decklist.new
    100.times { @decklist.cards.build }
  end

  # GET /decklists/1/edit
  def edit
  end

  # POST /decklists
  # POST /decklists.json
  def create
    @decklist = current_user.decklists.new(decklist_params)

    respond_to do |format|
      if @decklist.save
        format.html { redirect_to @decklist, notice: 'Decklist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @decklist }
      else
        format.html { render action: 'new' }
        format.json { render json: @decklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decklists/1
  # PATCH/PUT /decklists/1.json
  def update
    respond_to do |format|
      if @decklist.update(decklist_params)
        format.html { redirect_to @decklist, notice: 'Decklist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @decklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decklists/1
  # DELETE /decklists/1.json
  def destroy
    @decklist.destroy
    respond_to do |format|
      format.html { redirect_to decklists_url }
      format.json { head :no_content }
    end
  end

  def add_card(name, quantity)
    c = Card.new(name: name)
    @decklist.cards.create(card: c, quantity: quantity)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decklist
      @decklist = Decklist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def decklist_params
      params.require(:decklist).permit(:name, :description, cards_attributes: [:id, :name, :quantity])
    end
end
