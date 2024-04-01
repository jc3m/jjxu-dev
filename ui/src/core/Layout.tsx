import { Header } from './header';
import { Outlet } from 'react-router-dom';

export const Layout = () => {
  return (
    <div className="min-h-screen bg-neutral-900">
      <Header />
      <Outlet />
    </div>
  );
};
