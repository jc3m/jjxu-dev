import { Link } from 'components/link';
import { HEADER_SPACING_CLASS } from './spacing';

export const Header = () => {
  return (
    <div className={`${HEADER_SPACING_CLASS} absolute bg-neutral-900 w-full`}>
      <header className="container m-auto h-full flex items-center justify-end space-x-6">
        <Link href="/">Home</Link>
        <Link href="/about">About</Link>
        {/* <Link href="/blog">Blog</Link> */}
      </header>
    </div>
  );
};
