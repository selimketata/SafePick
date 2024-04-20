import React from 'react';
import { BrowserRouter as Router, Route, Routes, BrowserRouter } from 'react-router-dom';
import Sidebar from './Components/Sidebar/Sidebar';
import Products from './Pages/Products/Products'; // Import your Products component
import Users from './Pages/Users/Users'; // Import your Users component
import Community from './Pages/Community/Community'; // Import your Communities component
import Notifications from './Pages/Notifications/Notifications'; // Import your Notifications component
import './App.css';

function App() {
  return (
    <BrowserRouter>
    <Sidebar></Sidebar>
    <Routes>
      <Route path="/product" element={<Products />} />
      <Route path="/user" element={<Users />} />
      <Route path="/community" element={<Community />} />
      <Route path="/notification" element={<Notifications />} />

     </Routes>
    </BrowserRouter>
  );
}

export default App;
