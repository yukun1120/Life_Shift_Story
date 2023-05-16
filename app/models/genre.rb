class Genre < ActiveHash::Base
  self.data = [
    { id: 1, age: '---' },
    { id: 2, age: '10代' },
    { id: 3, age: '20代' },
    { id: 4, age: '30代' },
    { id: 5, age: '40代' },
    { id: 6, age: '50代' },
    { id: 7, age: '60代' },
    { id: 8, age: '70代' },
    { id: 9, age: '80代' },
    { id: 10, age: '90代' },
    { id: 11, age: '100代' }
  ]

  include ActiveHash::Associations
  has_many :experiences

  end