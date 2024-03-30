import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useHistory } from 'react-router-dom'; // Import useHistory hook for navigation

function Footer() {
  return (
    <footer style={footerStyle}>
      <p>Timesheet SMS &copy; {new Date().getFullYear()}</p>
    </footer>
  );
}

const footerStyle = {
  backgroundColor: '#333',
  color: '#fff',
  textAlign: 'center',
  padding: '1rem',
  position: 'fixed',
  left: 0,
  bottom: 0,
  width: '100%',
};

export default Footer;
