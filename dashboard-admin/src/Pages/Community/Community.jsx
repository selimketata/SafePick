import React, { useState, useEffect } from 'react';
import axios from 'axios';
import "./Community.css";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMinus, faPlus, faTrash } from '@fortawesome/free-solid-svg-icons';

// Définir l'URL de base
const BASE_URL = 'http://192.168.1.2:8000';

function CommunityDashboard() {
  const [communities, setCommunities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [openDetailsId, setOpenDetailsId] = useState(null);
  const [communityMessages, setCommunityMessages] = useState([]);
  const [newCommunityName, setNewCommunityName] = useState('');


  useEffect(() => {
    async function fetchCommunities() {
      try {
        const response = await axios.get(`${BASE_URL}/get_all_communities/`);
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
      await axios.post(`${BASE_URL}/remove_community/`, {
        community_name: communityName
      });
      const updatedCommunities = communities.filter((community) => community !== communityName);

      // Update state to reflect the deletion
      setCommunityMessages(updatedCommunities);
    } catch (error) {
      console.error('Error deleting community:', error);
    }
  };

  const handleDeleteMessage = async (message) => {
    try {
      await axios.delete(`${BASE_URL}/delete_message/`, {
        data: {
          email: message.email,
          timestamp: message.timestamp,
        },
      });
  
      // Mettre à jour l'état pour refléter la suppression
      const updatedMessages = communityMessages.filter((m) => m !== message);
      setCommunityMessages(updatedMessages);
    } catch (error) {      console.error('Erreur lors de la suppression du message :', error);
  }
};

const toggleDetails = async (communityName) => {
  setOpenDetailsId(openDetailsId === communityName ? null : communityName);
  if (openDetailsId === null) {
    try {
      const response = await axios.post(`${BASE_URL}/get_messages_in_community/`, {
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
const handleCreateCommunity = async () => {
  try {
    const response = await axios.post(`${BASE_URL}/add_community/`, {
      community_name: newCommunityName
    });
    console.log('New community created:', response.data);
    
    // Ajoutez le nouveau nom de communauté à votre état
    setCommunities([...communities, response.data.community_name]);
    // Effacer le champ de saisie après la création de la communauté
    setNewCommunityName('');
  } catch (error) {
    console.error('Error creating community:', error);
  }
};

return (
  <div className='productdash'>
    <h1>Community Dashboard</h1>
    <div className="create-community">
        <input 
          type="text" 
          placeholder="Enter new community name"
          value={newCommunityName}
          onChange={(e) => setNewCommunityName(e.target.value)}
        />
        <button onClick={handleCreateCommunity} className="create-community-button">Create New Community</button>
      </div>
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
                        <td><FontAwesomeIcon icon={faTrash} onClick={() => handleDeleteMessage(message)} /></td>
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

