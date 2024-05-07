import React from 'react';
import logo from "./../../Assets/logo.png";
import "./Sidebar.css";
import { Link } from 'react-router-dom';


function Sidebar() {
    return (
      <div className="sidebar">
        <img src={logo}></img>
        <h1>Safepick</h1>
        <div className='pageslist'>
            <Link to="/food" classname="page"><div>Foods</div></Link>
            <hr></hr>
            <Link to="/cosmetic" classname="page"><div>Cosmetics</div></Link>
            <hr></hr>
            <Link to="/user"><div>Users</div></Link>
            <hr></hr>
            <Link to="/community"><div>Community</div></Link>
            <hr></hr>
            <Link to="/notification"><div>Notifications</div></Link>
            <hr></hr>
            <Link to="/login"><div>Logout</div></Link>
        </div>
      </div>
    );
  }


export default Sidebar;
