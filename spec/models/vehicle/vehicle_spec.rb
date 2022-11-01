require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'falso quando modelo do veículo está vazio' do
        vehicle = Vehicle.new(brand_name:'Scania', license_plate:'XYZ-1235', fabrication_year:1995, full_capacity:1000)

        vehicle.valid?

        expect(vehicle.errors.include?(:model)).to be true  
        expect(vehicle.errors[:model]).to include("não pode ficar em branco")
      end
      it 'falso quando marca do veículo está vazia' do
        vehicle = Vehicle.new(model:'Scania', license_plate:'XYZ-1235', fabrication_year:1995, full_capacity:1000)

        vehicle.valid?

        expect(vehicle.errors.include?(:brand_name)).to be true  
        expect(vehicle.errors[:brand_name]).to include("não pode ficar em branco")
      end
      it 'falso quando ano de fabricação do veículo está vazio' do
        vehicle = Vehicle.new(model:'Scania', brand_name:'Linha R', license_plate:'XYZ-1235', full_capacity:1000)

        vehicle.valid?

        expect(vehicle.errors.include?(:fabrication_year)).to be true  
        expect(vehicle.errors[:fabrication_year]).to include("não pode ficar em branco")
      end
      it 'falso quando capacidade do veículo está vazia' do
        vehicle = Vehicle.new(model:'Scania', brand_name:'Linha R', license_plate:'XYZ-1235', fabrication_year: 1995)

        vehicle.valid?

        expect(vehicle.errors.include?(:full_capacity)).to be true  
        expect(vehicle.errors[:full_capacity]).to include("não pode ficar em branco")
      end
      it 'falso quando placa está em branco' do
        vehicle = Vehicle.new(license_plate:'')

        vehicle.valid?

        expect(vehicle.errors.include?(:license_plate)).to be true  
        expect(vehicle.errors[:license_plate]).to include("não pode ficar em branco")
      end
    end
    context 'numericality' do    
      it 'verdadeiro quando capacidade máxima de carga é positiva' do
        vehicle = Vehicle.new(full_capacity:1)

        vehicle.valid?

        expect(vehicle.errors.include?(:full_capacity)).to be false  
      end
      it 'falso quando capacidade máxima de carga é nula' do
        vehicle = Vehicle.new(full_capacity:0)

        vehicle.valid?

        expect(vehicle.errors.include?(:full_capacity)).to be true
        expect(vehicle.errors[:full_capacity]).to include("deve ser maior que 0") 
      end
      it 'falso quando capacidade máxima de carga é negativa' do
        vehicle = Vehicle.new(full_capacity:-1)

        vehicle.valid?

        expect(vehicle.errors.include?(:full_capacity)).to be true
        expect(vehicle.errors[:full_capacity]).to include("deve ser maior que 0") 

      end
      it 'verdadeiro quando modelo do veículo tem mais de quatro caracteres' do
        vehicle = Vehicle.new(model:'rails')

        vehicle.valid?

        expect(vehicle.errors.include?(:model)).to be false 
      end
      it 'verdadeiro quando modelo do veículo tem quatro caracteres' do
        vehicle = Vehicle.new(model:'Ford')

        vehicle.valid?

        expect(vehicle.errors.include?(:model)).to be false
      end
      it 'falso quando modelo do veículo tem menos de quatro caracteres' do
        vehicle = Vehicle.new(model:'Ka')

        vehicle.valid?

        expect(vehicle.errors.include?(:model)).to be true
        expect(vehicle.errors[:model]).to include("é muito curto (mínimo: 4 caracteres)") 
      end
      it 'falso quando modelo do veículo tem menos de quatro caracteres' do
        vehicle = Vehicle.new(brand_name:'Ka')

        vehicle.valid?

        expect(vehicle.errors.include?(:brand_name)).to be true
        expect(vehicle.errors[:brand_name]).to include("é muito curto (mínimo: 4 caracteres)") 
      end
      it 'verdadeiro quando marca do veículo tem quatro caracteres' do
        vehicle = Vehicle.new(brand_name:'Fiat')

        vehicle.valid?

        expect(vehicle.errors.include?(:brand_name)).to be false
      end
      it 'verdadeiro quando marca do veículo tem mais de quatro caracteres' do
        vehicle = Vehicle.new(brand_name:'rails')

        vehicle.valid?

        expect(vehicle.errors.include?(:brand_name)).to be false  
      end
    end 
    context 'format' do
      it "falso quando ano de fabricação não está no formato 'yyyy'" do
        vehicle = Vehicle.new(fabrication_year:'95')

        vehicle.valid?

        expect(vehicle.errors.include?(:fabrication_year)).to be true  
        expect(vehicle.errors[:fabrication_year]).to include("não possui o formato esperado")
      end
      it "falso quando placa não está no formato 'ABC-1234'" do
        vehicle = Vehicle.new(license_plate:'AB-1234')

        vehicle.valid?

        expect(vehicle.errors.include?(:license_plate)).to be true  
        expect(vehicle.errors[:license_plate]).to include("não possui o formato esperado")
      end
      it "verdadeiro quando ano de fabricação está no formato 'yyyy'" do
        vehicle = Vehicle.new(fabrication_year:'1995')

        vehicle.valid?

        expect(vehicle.errors.include?(:fabrication_year)).to be false  
      end
      it "verdadeiro quando placa está no formato 'ABC-1234'" do
        vehicle = Vehicle.new(license_plate:'ABC-1235')

        vehicle.valid?

        expect(vehicle.errors.include?(:license_plate)).to be false    
      end
    end
    context 'uniqueness' do
      it "falso quando número da placa não é único" do
        s = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                   min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
        vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                                  shipping_method_id: s.id, status:1)  
        second_vehicle = Vehicle.new(license_plate:'EFJ-1234')
        second_vehicle.valid?

        

        expect(second_vehicle.errors.include?(:license_plate)).to be true
        expect(second_vehicle.errors[:license_plate]).to include("já está em uso")
      end

      it "verdadeiro quando número da placa é único" do
        sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                    min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
        vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1253', 
                                  shipping_method_id: sm.id, status:1)  
        second_vehicle = Vehicle.new(license_plate:'EFJ-1235')

        vehicle.valid?

        expect(vehicle.errors.include?(:license_plate)).to be false
      end
    end
  end
end

