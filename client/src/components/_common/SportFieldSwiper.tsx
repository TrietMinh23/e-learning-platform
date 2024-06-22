"use client";
import React, { useState, useEffect, useMemo } from "react";
import { Carousel, Spin } from "antd";
import styles from "./SportFieldSwiper.module.scss";
import Image from "next/image";

const SportFieldSwiper: React.FC = () => {
  const images = useMemo(
    () => [
      "https://picsum.photos/360/360",
      "https://picsum.photos/360/361",
      "https://picsum.photos/360/362",
      "https://picsum.photos/360/363",
      "https://picsum.photos/360/364",
    ],
    []
  );

  const [loading, setLoading] = useState(true);

  // UseEffect to handle loading state
  useEffect(() => {
    const loadImage = () => {
      let loadedCount = 0;
      const totalImages = images.length;
      const handleImageLoad = () => {
        loadedCount++;
        if (loadedCount === totalImages) {
          setLoading(false);
        }
      };

      images.forEach((image) => {
        const img = new window.Image();
        img.src = image;
        img.onload = handleImageLoad;
      });
    };

    loadImage();
  }, [images]);

  return (
    <div className={styles.sliderContainer}>
      {loading ? (
        <div className="h-card w-full bg-accent-100 flex justify-center items-center rounded-large">
          <Spin size="large" />
        </div>
      ) : (
        <Carousel
          className="w-full h-card relative"
          autoplay
          arrows
          autoplaySpeed={2000}
          dotPosition="top"
          effect="scrollx"
        >
          {images.map((image, index) => (
            <div key={image} className="w-full h-card relative">
              <Image src={image} alt={`Slide ${index + 1}`} fill />
            </div>
          ))}
        </Carousel>
      )}
    </div>
  );
};

export default SportFieldSwiper;
