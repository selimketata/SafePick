import React, { useState, useEffect } from 'react';
import axios from 'axios';
import "./Food.css"

function Food() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchProducts() {
      try {
        const response = await axios.get('http://192.168.1.2:8000/foodDash/');
        setProducts(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching products:', error);
      }
    }

    fetchProducts();
  }, []);
console.log(products)
  return (
    <div className='productdash'>
      <h2>Food Dashboard</h2>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              {/* Add more columns as needed */}
            </tr>
          </thead>
          <tbody>
            {products['communities'].map((product) => (
              <tr>
                {product}
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

export default Food;
