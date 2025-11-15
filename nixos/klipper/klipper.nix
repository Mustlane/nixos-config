{ pkgs, lib, config, ... }:
  let
    serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
  in
  {
  options = {
    klipper.enable =
      lib.mkEnableOption "enables klipper";
};

config = lib.mkIf config.klipper.enable {
  services = {
    mainsail = {
      enable = true;
      hostName = "nixosserver";
    };

    moonraker = {
      enable = true;
      user = "root";
      address = "0.0.0.0";
      settings = {
        octoprint_compat = { };
        history = { };
        authorization = {
          force_logins = true;
          trusted_clients = [
            "10.0.0.0/16"
            "10.0.0.0/8"
            "127.0.0.0/8"
            "169.254.0.0/16"
            "172.16.0.0/12"
            "192.168.0.0/16"
            "FE80::/10"
            "::1/128"
          ];
          cors_domains = [
            "http://*.lan"
            "http://*.local"
            "https://my.mainsail.xyz"
            "http://my.mainsail.xyz"
            "https://app.fluidd.xyz"
            "http://app.fluidd.xyz"
          ];
        };
      };
    };

    klipper = {
      enable = true;
      user = "root";
      group = "root";
      firmwares = {
        mcu = {
          enable = true;
          configFile = /etc/nixos/hosts/server/extras/config;
        };
      };
      settings = {
        mcu = {
          serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
        };
        printer = {
          kinematics = "cartesian";
          max_velocity = 200;
          max_accel = 3000;
          max_z_velocity = 15;
          max_z_accel = 45;
          square_corner_velocity = 8.0;
        };
        stepper_x = {
          step_pin = "PC2";
          dir_pin = "!PB9";
          enable_pin = "!PC3";
          microsteps = 128;
          rotation_distance = 40;
          endstop_pin = "tmc2209_stepper_x:virtual_endstop";
          position_endstop = 0;
          position_max = 300;
          homing_speed = 40;
          homing_retract_dist = 0;
        };
        "tmc2209 stepper_x" = {
          uart_pin = "PC1";
          run_current = 0.820;
          stealthchop_threshold = 0;
          interpolate = false;
          sense_resistor = 0.150;
          uart_address = 3;
          driver_SGTHRS = 86;
          diag_pin = "PA5";
        };
        stepper_y = {
          step_pin = "PB8";
          dir_pin = "PB7";
          enable_pin = "!PC3";
          microsteps = 128;
          rotation_distance = 40;
          endstop_pin = "tmc2209_stepper_y:virtual_endstop";
          position_endstop = 0;
          position_max = 300;
          homing_speed = 40;
          homing_retract_dist = 0;
        };
        "tmc2209 stepper_y" = {
          uart_pin = "PC0";
          run_current = 0.880;
          stealthchop_threshold = 0;
          interpolate = false;
          sense_resistor = 0.150;
          uart_address = 3;
          driver_SGTHRS = 110;
          diag_pin = "PA6";
        };
        stepper_z = {
          step_pin = "PB6";
          dir_pin = "!PB5";
          enable_pin = "!PC3";
          microsteps = 128;
          rotation_distance = 4;
          endstop_pin = "probe:z_virtual_endstop";
          position_min = -4;
          position_max = 340;
          homing_speed = 5;
        };
        "tmc2209 stepper_z" = {
          uart_pin = "PA15";
          run_current = 0.800;
          stealthchop_threshold = 0;
          interpolate = false;
          sense_resistor = 0.150;
          uart_address = 3;
          diag_pin = "PA7";
        };
        extruder = {
          step_pin = "PB4";
          dir_pin = "!PB3";
          enable_pin = "!PC3";
          microsteps = 128;
          rotation_distance = 4.65;
          nozzle_diameter = 0.400;
          filament_diameter = 1.750;
          heater_pin = "PA1";
          sensor_type = "EPCOS 100K B57560G104F";
          sensor_pin = "PC5";
          control = "pid";
          pid_kd = 41.96;
          pid_kp = 15.66;
          pid_ki = 1.49;
          min_temp = 0;
          max_temp = 300;
          max_extrude_only_distance = 150.0;
          max_extrude_cross_section = 5;
        };
        "tmc2209 extruder" = {
          uart_pin = "PC14";
          run_current = 0.550;
          stealthchop_threshold = 0;
          interpolate = false;
          sense_resistor = 0.150;
          uart_address = 3;
        };
        heater_bed = {
          heater_pin = "PA2";
          sensor_type = "EPCOS 100K B57560G104F";
          sensor_pin = "PC4";
          control = "pid";
          pid_kp = 186.38;
          pid_ki = 36.12;
          pid_kd = 637.30;
          min_temp = 0;
          max_temp = 110;
        };
        fan = {
          pin = "PA0";
        };
        probe = {
          pin = "PB1";
          x_offset = 27;
          y_offset = -20;
          z_offset = 0;
          samples = 3;
          samples_result = "median";
          samples_tolerance = 0.01;
          samples_tolerance_retries = 5;
        };
        safe_z_home = {
          home_xy_position = "123,170";
          z_hop = 10;
          z_hop_speed = 5;
        };
        bed_mesh = {
          speed = 175;
          mesh_min = "27, 6";
          mesh_max = "299, 280";
          probe_count = "7, 7";
          algorithm = "bicubic";
          fade_start = 1;
          fade_end = 10;
          fade_target = 0;
        };
        axis_twist_compensation = {
          calibrate_start_x = 27;
          calibrate_end_x = 272;
          calibrate_y = 154;
        };
        screws_tilt_adjust = {
          screw1_name = "center front left base";
          screw1 = "84, 136";
          screw2_name = "front left";
          screw2 = "5, 55";
          screw3_name = "front right";
          screw3 = "244, 55";
          screw4_name = "center front right";
          screw4 = "164, 136";
          screw5_name = "center back left";
          screw5 = "84, 216";
          screw6_name = "center back right";
          screw6 = "164, 216";
          screw7_name = "back left";
          screw7 = "5, 295";
          screw8_name = "back right";
          screw8 = "244, 295";
          horizontal_move_z = "10";
          screw_thread = "CCW-M4";
        };
        "filament_switch_sensor filament_runout_sensor" = {
          switch_pin = "PA4";
          pause_on_runout = true;
          insert_gcode = ''
            { action_respond_info("Insert Detected") }
          '';
          runout_gcode = ''
            { action_respond_info("Runout Detected") }
          '';
        };
        virtual_sdcard = {
          path = "/home/mustlane/printer_data/gcodes";
        };
        display = {
          lcd_type = "st7920";
          cs_pin = "PB12";
          sclk_pin = "PB13";
          sid_pin = "PB15";
          encoder_pins = "^PB14, ^PB10";
          click_pin = "^!PB2";
        };
        "output_pin beeper" = {
          pin = "PC6";
          value = 0;
          shutdown_value = 0;
          pwm = true;
          cycle_time = 0.0005;
        };
        };
      };
    };
  };
}
