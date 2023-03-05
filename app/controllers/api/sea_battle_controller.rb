class Api::SeaBattleController < ApplicationController

	def index
		Rails.logger.info params
	end

	def show 
		sea_battle = SeaBattle.find(params[:id])
		render json: sea_battle, include: [:user, :turns, :ships => {:include => [:points, :hits]}], status: :ok
	end
	
	def create 
		sea_battle = SeaBattle.new({
			Axis: sea_battle_params[:Axis]
		})
		if sea_battle.save
			render json: sea_battle, status: :ok
		else
			render json: { errors: sea_battle.errors.full_messages }, status: 503
		end
	end

	def ship
		if ship_params[:Navy] == "Player"
			ship = create_player_ship(ship_params[:sea_battle_id], ship_params[:ShipType], ship_params[:Size], ship_params[:Points])
		else
			ship = create_opponent_ship(ship_params[:sea_battle_id], ship_params[:ShipType], ship_params[:Size])
		end
		render json: ship, include: [:points, :hits], status: :ok
	end

	def fire 
		if fire_params[:Navy] == "Player"
			turn = player_fire(fire_params[:sea_battle_id], fire_params[:Horizontal], fire_params[:Vertical])
		else
			turn = opponent_fire(fire_params[:sea_battle_id])
		end
		render json: turn, status: :ok
	end

	private

	def player_fire(id, horizontal, vertical)
		target = 'Miss'
		shipType = nil
		ships = SeaBattleShip.includes(:points,:hits).where(sea_battle_id: id, Navy: 'Opponent')
		ships.each do | ship |
			ship.points.each do | point |
				if point.Horizontal == horizontal && point.Vertical == vertical
					SeaBattleShipHit.create({
						sea_battle_ship_id: ship.id,
						Horizontal: horizontal,
						Vertical: vertical,
					})
					shipType = ship.Type
					target = 'Hit'
					if ship.hits.length + 1 == ship.Size
						target = 'Sunk'
						SeaBattleShip.update(ship.id, Sunk: true)
					end
					break
				end
			end
		end
		turn = SeaBattleTurn.create({
			sea_battle_id: id,
			Horizontal: horizontal,
			Vertical: vertical,
			Navy: 'Player',
			Target: target,
			ShipType: shipType
		})
	end

	def opponent_fire(id)
		point = get_opponent_fire_point(id)
		horizontal = point[:Horizontal]
		vertical = point[:Vertical]
		target = 'Miss'
		shipType = nil
		ships = SeaBattleShip.includes(:points,:hits).where(sea_battle_id: id, Navy: 'Player')
		ships.each do | ship |
			ship.points.each do | point |
				if point.Horizontal == horizontal && point.Vertical == vertical
					SeaBattleShipHit.create({
						sea_battle_ship_id: ship.id,
						Horizontal: horizontal,
						Vertical: vertical,
					})
					shipType = ship.Type
					target = 'Hit'
					if ship.hits.length + 1 == ship.Size
						target = 'Sunk'
						SeaBattleShip.update(ship.id, Sunk: true)
					end
					break
				end
			end
		end
		turn = SeaBattleTurn.create({
			sea_battle_id: id,
			Horizontal: horizontal,
			Vertical: vertical,
			Navy: 'Opponent',
			Target: target,
			ShipType: shipType
		})
	end

	def get_opponent_fire_point(id)
		maxH = ('A'..'Z').to_a
		maxV = (1..26).to_a
		sea_battle = SeaBattle.find(id)
		return [] if !sea_battle
		horizontal = maxH.take(sea_battle.Axis)
		vertical = maxV.take(sea_battle.Axis)
		occupied = []
		turns = SeaBattleTurn.where(sea_battle_id: id, Navy: 'Opponent')
		turns.each do | turn |
			occupied.push({ Horizontal: turn.Horizontal, Vertical: turn.Vertical })
		end
		point = {
			Horizontal: nil,
			Vertical: nil
		}
		while point[:Horizontal] == nil && point[:Vertical] == nil
			idxH = rand(sea_battle.Axis)
			idxV = rand(sea_battle.Axis)
			next if occupied.find { |p| p[:Horizontal] == horizontal[idxH] && p[:Vertical] == vertical[idxV] }
			point[:Horizontal] = horizontal[idxH]
			point[:Vertical] = vertical[idxV]
		end
		point
	end

	def create_player_ship(id, shipType, size, points)
		ship = SeaBattleShip.create({
			sea_battle_id: id,
			Type: shipType,
			Size: size,
			Navy: 'Player'
		})
		if ship
			points.each do | p |
				SeaBattleShipGridPoint.create({
					sea_battle_ship_id: ship.id,
					Horizontal: p[:Horizontal],
					Vertical: p[:Vertical]
				})
			end
		end
		ship
	end

	def create_opponent_ship(id, shipType, size)
		ship = SeaBattleShip.create({
			sea_battle_id: id,
			Type: shipType,
			Size: size,
			Navy: 'Opponent'
		})
		if ship
			points = available_opponent_grid_points(id, size)
			points.each do | p |
				SeaBattleShipGridPoint.create({
					sea_battle_ship_id: ship.id,
					Horizontal: p[:Horizontal],
					Vertical: p[:Vertical]
				})
			end
		end
		ship
	end

	def available_opponent_grid_points(id, size)
		maxH = ('A'..'Z').to_a
		maxV = (1..26).to_a
		sea_battle = SeaBattle.find(id)
		return [] if !sea_battle
		horizontal = maxH.take(sea_battle.Axis)
		vertical = maxV.take(sea_battle.Axis)
		occupied = []
		ships = SeaBattleShip.includes(:points).where(sea_battle_id: id, Navy: 'Opponent')
		ships.each do | ship |
			ship.points.each do | point |
				occupied.push({ Horizontal: point.Horizontal, Vertical: point.Vertical })
			end
		end

		points = []
		directions = ['right','down','left','up']
		while points.length < size
			points = []
			idxH = rand(sea_battle.Axis)
			idxV = rand(sea_battle.Axis)
			direction = directions[rand(4)]
			counter = 0
			while counter < size
				break if horizontal[idxH] == nil || vertical[idxV] == nil
				break if occupied.find { |p| p[:Horizontal] == horizontal[idxH] && p[:Vertical] == vertical[idxV] }
				point = {
					Horizontal: horizontal[idxH],
					Vertical: vertical[idxV]
				}
				points.push(point)
				case direction
				when 'right'
					idxH += 1
				when 'down'
					idxV += 1
				when 'left'
					idxH -= 1
				when 'up'
					idxV -= 1
				end
				counter += 1
			end
		end
		points
	end

	def sea_battle_params
		params.require(:sea_battle).permit(:Axis)
	end

	def ship_params 
		params.permit(:ShipType, :Size, :Navy, :sea_battle_id, :Points => [:Horizontal, :Vertical], :sea_battle => {})
	end

	def fire_params 
		params.permit(:Navy, :sea_battle_id, :Horizontal, :Vertical, :sea_battle => {})
	end

end
