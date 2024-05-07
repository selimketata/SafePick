import React, { useState, useEffect } from 'react';
import axios from 'axios';
import "./Cosmetic.css"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrash } from '@fortawesome/free-solid-svg-icons';

function Cosmetic() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const [productsPerPage] = useState(50); // Number of products to display per page
  const [searchCode, setSearchCode] = useState('');
  const [searchName, setSearchName] = useState('');
  const [searchResult, setSearchResult] = useState(null);

  useEffect(() => {
    async function fetchProducts() {
      try {
        const response = await axios.get('http://192.168.1.2:8000/cosmeticDash/');
        setProducts(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching products:', error);
      }
    }

    fetchProducts();
  }, []);

  // Pagination logic
  const indexOfLastProduct = currentPage * productsPerPage;
  const indexOfFirstProduct = indexOfLastProduct - productsPerPage;
  const currentProducts = products.slice(indexOfFirstProduct, indexOfLastProduct);

  // Change page
  const paginate = pageNumber => setCurrentPage(pageNumber);

  // Function to handle search by product code
  const handleSearchByCode = async () => {
    try {
      const response = await axios.get(`http://192.168.1.2:8000/cosmetics/${searchCode}/`);
      setSearchResult(response.data);
    } catch (error) {
      console.error('Error fetching product by code:', error);
      setSearchResult(null);
    }
  };

  // Function to handle search by product name
  const handleSearchByName = async () => {
    try {
      const response = await axios.get(`http://192.168.1.2:8000/get_cosmetics_by_name/${searchName}/`);
      setSearchResult(response.data);
    } catch (error) {
      console.error('Error fetching products by name:', error);
      setSearchResult(null);
    }
  };

  // Handle search on code change
  useEffect(() => {
    if (searchCode.trim() !== '') {
      handleSearchByCode();
    }
  }, [searchCode]);

  // Handle search on name change
  useEffect(() => {
    if (searchName.trim() !== '') {
      handleSearchByName();
    }
  }, [searchName]);

  return (
    <div className='productdash'>
      <h2>Cosmetic Dashboard</h2>
      <div className="search">
        <input
          type="text"
          placeholder="Enter product code"
          value={searchCode}
          onChange={(e) => setSearchCode(e.target.value)}
        />
        <button onClick={handleSearchByCode}>Search by Code</button>
        <input
          type="text"
          placeholder="Enter product name"
          value={searchName}
          onChange={(e) => setSearchName(e.target.value)}
        />
        <button onClick={handleSearchByName}>Search by Name</button>
      </div>
      {loading ? (
        <p>Loading...</p>
      ) : searchResult ? (
        <div>
          {Array.isArray(searchResult) ? (
            <div>
              <h3>Search Result</h3>
              <table>
                <thead>
                  <tr>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Brands</th>
                    <th>Categories</th>
                    <th>Pnns_groups_1</th>
                    <th>Delete</th>
                  </tr>
                </thead>
                <tbody>
                  {searchResult.map((result, index) => (
                    <tr key={index}>
                      <td>{result.code}</td>
                      <td>{result.product_name}</td>
                      <td>{result.brands}</td>
                      <td>{result.categories}</td>
                      <td>{result.pnns_groups_1}</td>
                      <td><FontAwesomeIcon icon={faTrash} /></td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <div>
              <h3>Search Result</h3>
              <table>
                <thead>
                  <tr>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Brands</th>
                    <th>Categories</th>
                    <th>Pnns_groups_1</th>
                    <th>Delete</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>{searchResult.code}</td>
                    <td>{searchResult.product_name}</td>
                    <td>{searchResult.brands}</td>
                    <td>{searchResult.categories}</td>
                    <td>{searchResult.pnns_groups_1}</td>
                    <td><FontAwesomeIcon icon={faTrash} /></td>
                  </tr>
                </tbody>
              </table>
            </div>
          )}
        </div>
      ) : (
        <div>
          <table>
            <thead>
              <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Brands</th>
                <th>Categories</th>
                <th>Pnns_groups_1</th>
                <th>Delete</th>
              </tr>
            </thead>
            <tbody>
              {currentProducts.map((product, index) => (
                <tr key={index}>
                  <td>{product.code}</td>
                  <td>{product.product_name}</td>
                  <td>{product.brands}</td>
                  <td>{product.categories}</td>
                  <td>{product.pnns_groups_1}</td>
                  <td><FontAwesomeIcon icon={faTrash} /></td>
                </tr>
              ))}
            </tbody>
          </table>
          {/* Pagination controls */}
          <div className="pagination">
            {Array.from({ length: Math.ceil(products.length / productsPerPage) }).map((_, index) => (
              <button key={index} className={currentPage === index + 1 ? 'pag current' : 'pag'} onClick={() => paginate(index + 1)}>{index + 1}</button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export default Cosmetic;
