import { cn } from "@/libs/utils";
import { Button, ConfigProvider, Pagination } from "antd";
import s from "./CreateCourseForm.module.scss";
import React from "react";
import { ArrowLeftOutlined, ArrowRightOutlined } from "@ant-design/icons";
import { Input } from "antd";
import { UserOutlined } from '@ant-design/icons';


const CreateCourseForm = () => {
  return (
    <div
      className={cn(
        s.createFormContainer,
        "bg-white m-auto w-4/5 - h-full flex flex-col gap-4 justify-center items-center"
      )}
    >
      <ConfigProvider
        theme={{
          components: {
            Input: {
              activeBorderColor: 'red'
            },
          },
        }}
      >
        <Input placeholder="default size" prefix={<UserOutlined />} />
      </ConfigProvider>
      <p>CreateCourseForm</p>
      <Button type="primary" className="mt-12">
        <ArrowLeftOutlined />
        Previous
      </Button>
      <Button type="primary" id="previous" className="mt-12">
        Next
        <ArrowRightOutlined />
      </Button>
    </div>
  );
};

export default CreateCourseForm;
