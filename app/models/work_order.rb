class WorkOrder < ApplicationRecord
  has_one :expressa
  has_one :sedex_dez
  has_one :sedex
end
