defmodule Membrane.RTP.G7221.Depayloader do
  @moduledoc """
  Parses RTP payloads into parseable G7221 Packets

  Based on [RFC 3551](https://tools.ietf.org/html/rfc3551).
  """

  use Membrane.Filter

  alias Membrane.{G7221, RTP, RemoteStream}

  def_input_pad :input, accepted_format: RTP

  def_output_pad :output,
    accepted_format: %RemoteStream{type: :packetized, content_format: G7221}

  @impl true
  def handle_stream_format(:input, _stream_format, _context, state) do
    {
      [stream_format: {:output, %RemoteStream{type: :packetized, content_format: G7221}}],
      state
    }
  end

  @impl true
  def handle_buffer(:input, buffer, _ctx, state) do
    {[buffer: {:output, buffer}], state}
  end
end
