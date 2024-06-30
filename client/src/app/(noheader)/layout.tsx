import React from 'react'

type NoHeaderProps = {
  children: React.ReactNode;
};

const layout = ({children}: NoHeaderProps) => {
  return (
    <div>
      <main>
        <p>Header</p>
        {children}
        <p>Footer</p>
      </main>
    </div>
  )
}

export default layout
