import {
  createBrowserRouter,
  RouterProvider as RouterProviderBase,
} from 'react-router-dom';

import { Landing } from 'pages/landing';
import { About } from 'pages/about';
import { Blog } from 'pages/blog';

import { Layout } from './layout';

const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    children: [
      {
        path: '',
        element: <Landing />,
      },
      {
        path: 'about',
        element: <About />,
      },
      {
        path: 'blog',
        element: <Blog />,
      },
    ],
  },
]);

export const RouterProvider = () => {
  return <RouterProviderBase router={router} />;
};
