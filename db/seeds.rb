# Création de catégories
5.times do
  category_name = Faker::Commerce.department
  Category.find_or_create_by(name: category_name)
end

# Création de marques
10.times do
  brand_name = Faker::Company.name
  Brand.find_or_create_by(name: brand_name)
end

# Création de produits
50.times do
  product_name = Faker::Commerce.product_name
  next if Product.exists?(name: product_name)  # Vérifie si le produit existe déjà

  raw_price = Faker::Number.between(from: 100, to: 10000) / 100.0
  price = (raw_price - 0.01).round(2)

  Product.create(
    name: product_name,
    price: price,
    inventory: Faker::Number.between(from: 10, to: 100),
    brand: Brand.all.sample,      # Utilise un objet Brand existant
    category: Category.all.sample # Utilise un objet Category existant
  )
end

# Création de commandes
20.times do
  order_date = Faker::Date.backward(days: 30) # Commande effectuée dans les 30 derniers jours

  # Trouve ou crée une commande pour une date donnée
  order = Order.find_or_create_by(order_date: order_date) do |new_order|
    new_order.status = ['processing', 'shipped', 'delivered', 'cancelled'].sample
  end

  if order.order_items.empty? # Continue seulement si aucun OrderItem n'existe pour cette commande
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
end

Product.find_each do |product|
  rand(3..8).times do
    product.reviews.create(
      rating: Faker::Number.between(from: 1, to: 5),
      comment: Faker::Lorem.sentence(word_count: 15)
    )
  end
end


puts "Données de seed créées avec succès!"
