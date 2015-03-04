# encoding: utf-8
require 'spec_helper'
require 'enel'
require 'thor'

describe Enel do
  context :define_call_command do
    let(:hoge) do
      class Hoge < ::Thor
        extend Enel

        desc 'all', 'show all boards [id,name]'
        def all
        end

        desc 'find [board_id]', 'show board'
        def find(_board_id)
        end

        define_call_command(proc do |*args|
          args
        end)
      end
      Hoge.new
    end

    cases = [
      {
        case_no: 1,
        case_title: 'case_title',
        expected: [:all, 'args1', 'args2']
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          actual = hoge.all('args1', 'args2')

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        # implement each case before
      end

      def case_after(_c)
        # implement each case after
      end
    end
  end
end
