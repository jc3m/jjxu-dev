import { Outlet } from 'react-router-dom';

import { Header } from './header';

export const Layout = () => {
  return (
    <div className="min-h-screen bg-neutral-900">
      <Header />
      <Outlet />
    </div>
  );
};
