import { useMemo } from 'react';
import { images } from './images';

const formatter = new Intl.DateTimeFormat('en-US', {
  day: 'numeric',
  month: 'long',
  year: 'numeric',
});

export const Landing = () => {
  const image = useMemo(() => {
    return images[Math.floor(Math.random() * images.length)];
  }, []);

  return (
    <main className="h-screen container m-auto flex max-md:flex-col items-center justify-center space-x-16 space-y-24">
      <section className="md:pl-16 max-md:pt-4 md:max-w-[60vw] max-md:max-h-[50vh] md:grow-[2] flex flex-col items-center">
        <img
          src={image.src}
          alt={image.alt}
          className="shrink pt-6 object-contain max-h-full md:max-h-[calc(90vh-130px)]"
        />
        <p className="font-serif text-sm text-zinc-300 pt-4">{image.alt}</p>
        <p className="font-serif text-sm text-zinc-300">
          {formatter.format(image.date)}
        </p>
      </section>
      <section className="md:pr-16 flex flex items-center md:grow">
        <div className="w-[300px] flex flex-col items-end">
          <h1 className="font-serif font-bold text-8xl pb-6 text-zinc-200">
            JJ Xu
          </h1>
          <p className="font-serif">
            GitHub: @
            <a className="underline" href="https://github.com/jc3m">
              jc3m
            </a>
          </p>
          <p className="font-serif">
            LinkedIn: @
            <a
              className="underline"
              href="https://www.linkedin.com/in/jonathanjxu/"
            >
              jonathanjxu
            </a>
          </p>
          <p className="font-serif text-right pt-6">
            Software engineer. Fan of photography, robotics, and tennis.
          </p>
        </div>
      </section>
    </main>
  );
};
