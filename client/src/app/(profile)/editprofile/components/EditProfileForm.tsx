'use client';
import React from 'react';
import type { FormProps } from 'antd';
import { cn } from "@/libs/utils";
import s from "./EditProfileForm.module.scss";
import { Button, Checkbox, Form, Input } from 'antd';

type FieldType = {
  firstName?: string;
  lastName?: string;
  password?: string;
  remember?: string;
};


const EditProfileForm: React.FC = () =>  {
  
  const onFinish = async(value: FieldType) => {
    console.log('Value from input form: ', value);
  };

  return (
  <Form
    name="basic"
    labelCol={{ span: 8 }}
    wrapperCol={{ span: 16 }}
    style={{ maxWidth: 600 }}
    initialValues={{ remember: true }}
    autoComplete="off"
    onFinish={onFinish}
    className={cn(s.editProfileFormContainer)}
  >
    <Form.Item<FieldType>
      label="FirstName"
      name="firstName"
      rules={[{ required: true, message: 'Please input your first name!' }]}
    >
      <Input />
    </Form.Item>

    <Form.Item<FieldType>
      label="LastName"
      name="lastName"
      rules={[{ required: true, message: 'Please input your last name!'}]}
      >
        <Input />
      </Form.Item>

    <Form.Item<FieldType>
      label="Password"
      name="password"
      rules={[{ required: true, message: 'Please input your password!' }]}
    >
      <Input.Password />
    </Form.Item>

    <Form.Item<FieldType>
      name="remember"
      valuePropName="checked"
      wrapperCol={{ offset: 8, span: 16 }}
    >
      <Checkbox>Remember me</Checkbox>
    </Form.Item>

    <Form.Item wrapperCol={{ offset: 8, span: 16 }}>
      <Button id="btnsubmit" type="primary" htmlType="submit">
        Submit
      </Button>
    </Form.Item>
  </Form>
  )
};

export default EditProfileForm;