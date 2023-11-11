# Création de catégories
5.times do
  Category.create(name: Faker::Commerce.department)
end
  
# Création de marques
10.times do
  Brand.create(name: Faker::Company.name)
end
  
# Création de produits
50.times do
  # Génère un prix entre un minimum et un maximum, ici entre 1 et 100 euros
  raw_price = Faker::Number.between(from: 100, to: 10000) / 100.0
  # Assurez-vous que le prix a deux chiffres après la virgule et termine par 0.99
  price = (raw_price - 0.01).round(2)
  
  Product.create(
    name: Faker::Commerce.product_name,
    price: price,
    inventory: Faker::Number.between(from: 10, to: 100),
    brand_id: Brand.pluck(:id).sample,
    category_id: Category.pluck(:id).sample
  )
end

# Création de commandes
20.times do
  order = Order.create(
    status: ['processing', 'shipped', 'delivered', 'cancelled'].sample,
    order_date: Faker::Date.backward(days: 30) # Commande effectuée dans les 30 derniers jours
  )

  total_price = 0

  # Création de 2 à 5 OrderItems par commande
  rand(2..5).times do
    product = Product.order(Arel.sql('RANDOM()')).first # Sélectionne un produit aléatoire
    quantity = Faker::Number.between(from: 1, to: 10)

    item_price = product.price * quantity
    total_price += item_price

    OrderItem.create(
      order_id: order.id,
      product_id: product.id,
      quantity: quantity,
      price: item_price # Prix total pour cet OrderItem
    )
  end

  # Mise à jour du prix total de la commande
  order.update(total_price: total_price.round(2))
end


puts "Données de seed créées avec succès!"
  