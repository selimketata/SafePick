import React, { useState, useEffect } from 'react';
import axios from 'axios';
import "./Community.css";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMinus, faPlus, faTrash } from '@fortawesome/free-solid-svg-icons';

function CommunityDashboard() {
  const [communities, setCommunities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [openDetailsId, setOpenDetailsId] = useState(null);
  const [communityMessages, setCommunityMessages] = useState([]);

  useEffect(() => {
    async function fetchCommunities() {
      try {
        const response = await axios.get('http://192.168.1.236:8000/get_all_communities/');
        setCommunities(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching communities:', error);
      }
    }

    fetchCommunities();
  }, [communities]);

  const handleDeleteCommunity = async (communityName) => {
    try {
      await axios.post('http://192.168.1.236:8000/remove_community/', {
        community_name: communityName
      });
      const updatedCommunities = communities.filter((community) => community !== communityName);

      // Update state to reflect the deletion
      setCommunities(updatedCommunities);
    } catch (error) {
      console.error('Error deleting community:', error);
    }
  };

  const toggleDetails = async (communityName) => {
    setOpenDetailsId(openDetailsId === communityName ? null : communityName);
    if (openDetailsId === null) {
      try {
        const response = await axios.post('http://192.168.1.236:8000/get_messages_in_community/', {
          community_name: communityName
        });
        // Sort messages by timestamp in descending order
        const sortedMessages = response.data.messages.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
        setCommunityMessages(sortedMessages);
      } catch (error) {
        console.error('Error fetching community messages:', error);
      }
    } else {
      setCommunityMessages([]);
    }
  };

  return (
    <div className='productdash'>
      <h1>Community Dashboard</h1>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <ul>
          {communities['communities'].map((community) => (
            <li key={community}>
              <div className='community'>
                <div>{community}</div>
                <div className='communityIcon'>
                  <FontAwesomeIcon icon={faTrash} onClick={() => handleDeleteCommunity(community)} />
                  <FontAwesomeIcon icon={openDetailsId === community ? faMinus : faPlus} onClick={() => toggleDetails(community)} />
                </div>
              </div>
              {openDetailsId === community && (
                <div>
                  <h2>Community Details</h2>
                  <table>
                    <thead>
                      <tr>
                        <th>Email</th>
                        <th>Content</th>
                        <th>Timestamp</th>
                        <th>Delete</th>
                      </tr>
                    </thead>
                    <tbody>
                      {communityMessages.map((message, index) => (
                        <tr key={index}>
                          <td>{message.email}</td>
                          <td>{message.content}</td>
                          <td>{new Date(message.timestamp).toLocaleString()}</td>
                          <td><FontAwesomeIcon icon={faTrash} onClick={() => handleDeleteCommunity(community)} /></td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
              <br />
              <hr />
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default CommunityDashboard;
