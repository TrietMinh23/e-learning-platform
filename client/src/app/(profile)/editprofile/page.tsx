import React from 'react'
import EditProfileForm from './components/EditProfileForm'

const page = () => {
  return (
    <div className="w-full flex justify-center my-5 h-full items-center">
      <div className="border-2 rounded-md border-gray-200	 p-8">
        <EditProfileForm />
      </div>
    </div>
  )
}

export default page
