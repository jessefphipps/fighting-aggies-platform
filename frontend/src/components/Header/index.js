import React from 'react';
import { Link } from 'react-router-dom';

import * as ROUTES from '../../constants/routes';

const Header = () => {
  return (
    <div>
      <nav className='navbar bg-light'>
        <div class="container-fluid">
          <span>
            <Link to={ROUTES.INDEX}>
              <h1>Fightin Aggies Platform</h1>
            </Link>
          </span>

          <span>
            <Link to={ROUTES.LOG_IN}>
              Log In
            </Link>
          </span>
        </div>
      </nav>
    </div>
  );
};

export default Header;