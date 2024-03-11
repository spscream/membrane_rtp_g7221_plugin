defmodule Membrane.RTP.G7221.Payloader do
  @moduledoc """
  Parses RTP payloads into parseable G7221 packets.

  Based on [RFC 3551](https://tools.ietf.org/html/rfc3551).
  """

  use Membrane.Filter

  alias Membrane.{G7221, RemoteStream, RTP}

  def_input_pad :input,
    accepted_format:
      any_of(
        %G7221{},
        %RemoteStream{type: :packetized, content_format: content_format}
        when content_format in [G7221, nil]
      )

  def_output_pad :output, accepted_format: RTP

  @impl true
  def handle_stream_format(:input, _stream_format, _ctx, state) do
    {[stream_format: {:output, %RTP{}}], state}
  end

  @impl true
  def handle_buffer(:input, buffer, _ctx, state) do
    {[buffer: {:output, buffer}], state}
  end
end
