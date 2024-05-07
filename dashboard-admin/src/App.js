import React from 'react';
import { BrowserRouter as Router, Route, Routes, BrowserRouter } from 'react-router-dom';
import Sidebar from './Components/Sidebar/Sidebar';
import Food from './Pages/Food/Food'; // Import your Products component
import Users from './Pages/Users/Users'; // Import your Users component
import Community from './Pages/Community/Community'; // Import your Communities component
import Notifications from './Pages/Notifications/Notifications'; // Import your Notifications component
import './App.css';
import Cosmetic from './Pages/Cosmetic/Cosmetic';

function App() {
  return (
    <BrowserRouter>
    <Sidebar></Sidebar>
    <Routes>
      <Route path="/food" element={<Food />} />
      <Route path="/cosmetic" element={<Cosmetic />} />
      <Route path="/user" element={<Users />} />
      <Route path="/community" element={<Community />} />
      <Route path="/notification" element={<Notifications />} />

     </Routes>
    </BrowserRouter>
  );
}

export default App;
