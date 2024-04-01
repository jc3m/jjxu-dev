import { Link } from 'components/link';

export const Personal = () => {
  return (
    <section className="font-serif max-w-prose">
      <p className="mb-4">
        Hi, I'm JJ and I'm a software engineer based out of Chicago.
      </p>
      <p className="mb-4">
        This is my place to write about web development, robotics, and anything
        else that interests me! Check out the <Link href="/blog">blog</Link> for
        more.
      </p>
      <h6 className="text-xl font-bold">What I've done</h6>
      <ul className="list-disc list-inside">
        <li>
          Founding software engineer at{' '}
          <Link external href="https://www.hardfin.com/">
            Hardfin
          </Link>{' '}
          (2023 - present)
        </li>
        <li>
          Software mentor for FRC Team{' '}
          <Link external href="https://www.thebluealliance.com/team/8122">
            8122
          </Link>{' '}
          (2024 - present)
        </li>
        <li>
          Software engineer at{' '}
          <Link external href="https://google.com">
            Google
          </Link>{' '}
          (2019 - 2023)
          <ul className="list-disc list-inside ml-4">
            <li>Google Cloud + Google Pixel Watch teams</li>
          </ul>
        </li>
        <li>
          Computer Engineering at{' '}
          <Link external href="https://ece.illinois.edu/">
            UIUC
          </Link>{' '}
          (2015 - 2019)
        </li>
        <li>Captain of FTC Team 5200 (2011 - 2015)</li>
      </ul>
    </section>
  );
};
