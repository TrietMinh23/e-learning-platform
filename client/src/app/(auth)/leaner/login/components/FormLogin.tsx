"use client";
import React from "react";
import type { FormProps } from "antd";
import { Button, Checkbox, ConfigProvider, Form, Input } from "antd";
import { emailRules } from "@utils/validationRules";
import { LockOutlined, UserOutlined } from "@ant-design/icons";
import s from "./FormLogin.module.scss";
import { cn } from "@/libs/utils";
import Link from "next/link";
import { ArrowRightOutlined } from "@ant-design/icons";

type FieldType = {
  email?: string;
  password?: string;
};

const onFinish: FormProps<FieldType>["onFinish"] = (values) => {
  console.log("Success:", values);
};

const onFinishFailed: FormProps<FieldType>["onFinishFailed"] = (errorInfo) => {
  console.log("Failed:", errorInfo);
};

const FormLogin = () => {
  return (
    <ConfigProvider
      theme={{
        components: {
          Form: {},
        },
      }}
    >
      <div className={cn(s.loginFormContainer, "md:p-14  p-2")}>
        <Form
          name="basic"
          layout="vertical"
          labelCol={{ span: 8 }}
          wrapperCol={{ span: 24 }}
          style={{ maxWidth: 600 }}
          onFinish={onFinish}
          onFinishFailed={onFinishFailed}
          autoComplete="off"
          requiredMark={false}
          size="large"
        >
          <h2 className="font-semibold  text-3xl md:text-4xl">Login</h2>
          <Form.Item<FieldType> label="Email" name="email" rules={emailRules}>
            <Input
              prefix={<UserOutlined className="site-form-item-icon" />}
              placeholder="Username"
            ></Input>
          </Form.Item>

          <Form.Item<FieldType>
            label="Password"
            name="password"
            style={{ marginBottom: 0 }}
            rules={[{ required: true, message: "Please input your password!" }]}
          >
            <Input.Password
              prefix={<LockOutlined className="site-form-item-icon" />}
              placeholder="Password"
            />
          </Form.Item>
          <Form.Item>
            <Link className="login-form-forgot" href="#">
              Forgot password
            </Link>
            <div>
              Don’t have an account?{" "}
              <Link href="#" id="btn-register">
                register now!
              </Link>
            </div>
          </Form.Item>

          <Form.Item wrapperCol={{ offset: 8, span: 16 }}>
            <Button type="primary" htmlType="submit">
              Login <ArrowRightOutlined />
            </Button>
          </Form.Item>
        </Form>
      </div>
    </ConfigProvider>
  );
};

export default FormLogin;
